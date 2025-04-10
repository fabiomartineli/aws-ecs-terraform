import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { HealthController } from './health.controller';
import { AppController } from './app.controller';
import { AppVariablesService } from './app-variables.service';

@Module({
  imports: [ConfigModule.forRoot({
    ignoreEnvFile: true
  })],
  controllers: [AppController, HealthController],
  providers: [AppVariablesService]
})
export class AppModule {}
