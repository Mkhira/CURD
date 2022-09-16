import * as mongoose from '../../boot/databases/index'
import UserModel, { UserRolesTypes } from '../models/user/user.model';

async function startSeed() {
    await mongoose.mongodb.mongooseConnections['core'].connection.db.dropDatabase();

    await UserModel.create({
        name: {
            firstName: "Mustafa",
            lastName: "Abdelbadea"
        },
        email: "mustafa.abdelbadea@gmail.com",
        password: "mustafa.abdelbadea@gmail.com",
        role: UserRolesTypes.admin,
    })
}



export {
    startSeed
}