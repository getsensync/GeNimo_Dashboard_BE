/* Replace with your SQL commands */

-- ### PART 1 - DELETE DATA
DELETE FROM public.credentials WHERE id BETWEEN 1 AND 2;

DELETE FROM public.customers WHERE customerid BETWEEN 1 AND 11;

DELETE FROM public.spots WHERE spotid BETWEEN 1 AND 12;

DELETE FROM public.payments WHERE paymentid BETWEEN 1 AND 45;

DELETE FROM public.deposits WHERE depositid BETWEEN 1 AND 82;
