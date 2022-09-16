import { Router } from 'express';
import swaggerJSDoc from 'swagger-jsdoc';
import { UserRouter } from './user';
import swaggerUi  from 'swagger-ui-express'
import swaggerJsdoc from 'swagger-jsdoc'
import * as servers from '../../../../boot/servers'
const router = Router();


router.use('/user', UserRouter)




export const VersionOneRoutes = router;
