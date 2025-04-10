import { Injectable, Scope } from "@nestjs/common";
import { ConfigService } from "@nestjs/config";
import { GetParametersCommand, SSMClient } from "@aws-sdk/client-ssm";

export interface IAppVariablesService {
    getValueAsync<TContent>(key: string): Promise<TContent>;
}

@Injectable({ scope: Scope.DEFAULT })
export class AppVariablesService {
    private readonly _client: SSMClient;
    private readonly _parameters: Map<string, string>;

    constructor(configService: ConfigService) {
        console.log("Creating Parameter Store client...");

        this._client = new SSMClient({
            region: configService.get("aws_region"),
            credentials: {
                accessKeyId: configService.get("aws_acesskey"),
                secretAccessKey: configService.get("aws_secretKey"),
            },
        });

        this._parameters = new Map<string, string>();
    }

    async getValueAsync(key: string): Promise<any> {
        if (this._parameters.has(key)) {
            const value = this._parameters.get(key);
            return value;
        }

        const parameterStorageValue = await this._client.send(new GetParametersCommand({ Names: [key] }));

        if (parameterStorageValue.Parameters?.length > 0) {
            const value = parameterStorageValue.Parameters[0].Value;
            this._parameters.set(key, value);

            return value;
        }
    }
}