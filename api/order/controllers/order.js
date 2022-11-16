'use strict';
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);

/**
 * Read the documentation (https://strapi.io/documentation/v3.x/concepts/controllers.html#core-controllers)
 * to customize this controller
 */

module.exports = {
  async create(ctx) {
    const { token, products, idUser, addressShipping } = ctx.request.body;
    const currency = 'mxn';
    const divisa = 100;
    let totalPayment = 0;
    products.forEach((product) => {
      totalPayment = totalPayment + product.price;
    });

    const charge = await stripe.charges.create({
      amount: totalPayment * divisa,
      currency,
      source: token.id,
      description: `ID Usuario: ${idUser}`,
    });

    const createOrder = [];
    for await (const product of products) {
      const data = {
        game: product.id,
        user: idUser,
        totalPayment,
        idPayment: charge.id,
        addressShipping,
      };
      const validData = await strapi.entityValidator.validateEntityUpdate(
        strapi.models.order,
        data,
      );
      const entry = await strapi.query('order').create(validData);
      createOrder.push(entry);
    }
    return createOrder;
  },
};
