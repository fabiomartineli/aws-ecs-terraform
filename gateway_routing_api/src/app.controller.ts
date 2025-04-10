import { Controller, Get, Inject, Param, Res } from '@nestjs/common';
import { AppVariablesService, IAppVariablesService } from './app-variables.service';
import { Response } from 'express';
import { ConfigService } from '@nestjs/config';

@Controller("params")
export class AppController {
  constructor(@Inject(AppVariablesService) private readonly appVariables: IAppVariablesService,
                private readonly configService: ConfigService
  ) { }

  @Get()
  async getParam(@Res() response: Response): Promise<Response> {
    const result = await this.appVariables.getValueAsync<string>(this.configService.get("application_name"));
    response.status(200).json({ param: result });

    return response;
  }
}
