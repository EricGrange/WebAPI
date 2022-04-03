unit WebAPI.Promises;

interface

type
   JPromise<ResultType> = class external 'Promise'

      constructor Create(func : procedure (resolve, reject : procedure (value : ResultType)));

      function &Then(func : procedure (value : ResultType)) : JPromise<ResultType>; external 'then';
      function Catch(func : procedure (error : ResultType)) : JPromise<ResultType>; external 'catch';
      function &Finally(func : procedure) : JPromise<ResultType>; external 'catch';

   end;
