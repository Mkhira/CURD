import { ObjectID } from "bson";
import { Model } from "mongoose";

class Crud {
  async insert<D, T>(model: Model<D>, data: T): Promise<any> {
    try {
      const document = new model(data);
      const insertedDoc = await document.save();

      return insertedDoc;
    } catch (error) {
      console.log(error);
      throw new error("Something Went Wrong", 500);
    }
  }

  async getById<D, T = ObjectID>(model: Model<D>, _id: T, options?: {}) {
    try {
      const doc = await model.findOne(_id);
      return doc;
    } catch (error) {
      throw new error("Something Went Wrong", 500);
    }
  }

  async findOneByFilter<D, T>(model: Model<D>, filter: T, options?: {}) {
    try {
      const doc = await model.findOne(filter)
      return doc
    } catch (error) {
      throw new error("Something Went Wrong", 500);
    }
  }

  async findOneAndUpdate<D, T>(model: Model<D>, filter: T, data: any) {
    try {
      const doc = await model.findOneAndUpdate(filter, data, { returnNewDocument: true })

      return doc
    } catch (error) {
      throw new error("Something Went Wrong", 500);
    }
  }

  async findOneAndDelete<D, T>(model: Model<D>, filter: T) {
    try {
      const doc = await model.findOneAndDelete(filter)

      return doc
    } catch (error) {
      throw new error("Something Went Wrong", 500);
    }
  }
}

export default new Crud();
