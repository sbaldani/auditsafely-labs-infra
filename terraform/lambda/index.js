exports.handler = async (event) => {
  console.log('SQS event received:', JSON.stringify(event, null, 2));

  for (const record of event.Records) {
    const body = JSON.parse(record.body);
    const message = JSON.parse(body.Message);

    console.log('scan.completed event:', JSON.stringify(message, null, 2));

    // Phase 3: trigger analysis worker here
  }
};
