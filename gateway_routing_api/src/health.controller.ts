import { Controller, Get, Res } from '@nestjs/common';
import { Response } from 'express';

@Controller("health")
export class HealthController {
  constructor() { }

  @Get()
  async getParam(@Res() response: Response): Promise<Response> {
    response.status(200).json({ status: "ok", app: `${process.env.application_name}` });

    return response;
  }
}
