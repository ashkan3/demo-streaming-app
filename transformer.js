'use strict';
console.log('Loading function');


exports.handler = (event, context, callback) => {
    let success = 0; // Number of valid entries found
    let failure = 0; // Number of invalid entries found

    /* Process the list of records and transform them */
    const output = event.records.map((record) => {

        const payload = (Buffer.from(record.data, 'base64')).toString('ascii');
        const columns = payload.split('|');

        if (columns) {
            const result = {
                customEventId: columns[0],
                lastSearchId: columns[1],
                datetime: columns[2],
                userAgent: columns[3],
                isInternal: columns[4],
                operatingSystemWithVersion: columns[5],
                country: columns[6],
                city: columns[7],
                language: columns[8],
                browserWithVersion: columns[9],
                userName: columns[10],
                splitTestRunVersion: columns[11],
                anonymous: columns[12],
                browser: columns[13],
                userId: columns[14],
                deviceCategory: columns[17],
                originLevel1: columns[19],
                region: columns[20],
                eventValue: columns[22],
                customDatas: columns[23],
                customEventCustomData: columns[24],
                eventType: columns[25],
                visitorId: columns[26],
                customEventOriginLevel1: columns[27],
                customEventOriginLevel2: columns[28],
                mobile: columns[29],
                visitId: columns[30],
                c_jsuiversion: columns[37]
            };
            success++;
            return {
                recordId: record.recordId,
                result: 'Ok',
                data: (Buffer.from(JSON.stringify(result))).toString('base64'),
            };
        } else {
            failure++;
            return {
                recordId: record.recordId,
                result: 'ProcessingFailed',
                data: record.data,
            };
        }
    });
    console.log(`Processing completed.  Successful records ${success}, Failed records ${failure}.`);
    callback(null, { records: output });
};
