import { ErrorSchema } from "./types";



export function serviceErrorHandler(error: Error, extra?: any) {
    const errorResponse: ErrorSchema = {
        message: error.message
    }

    if (extra?.path) {
        errorResponse.path = extra.path
      }
    
      if (extra?.code) {
        errorResponse.code = extra.code
      }

      throw errorResponse
}