From: Kolacinski, Karol <karol.kolacinski@intel.com>
Date: Fri, 22 Apr 2022 11:44:22 +0000
Subject: [Intel-wired-lan] [PATCH intel-next 1/3] ice: remove u16
 arithmetic in ice_gnss
In-Reply-To: <730b2502-3aa4-e5b9-be37-cc60e716e318@molgen.mpg.de>
References: <20220415103139.794790-1-karol.kolacinski@intel.com>
 <730b2502-3aa4-e5b9-be37-cc60e716e318@molgen.mpg.de>
Message-ID: <MW4PR11MB5800880B4C413D8669D436A986F79@MW4PR11MB5800.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Paul,

Thank you for your review.

On 4/15/22 3:51 PM, Paul Menzel wrote:
>> Change u16 to u32 where arithmetic occured.
>
>occur*r*e*s*
>
>Why does 16-bit width not work?

In the previous GNSS patch review, David Laight wrote that I should not do
arithmetic on anything smaller than 'int'.

>
>> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
>> ---
>>?? drivers/net/ethernet/intel/ice/ice_gnss.c | 6 +++---
>>?? 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
>> index 57586a2e6dec..f0b2091c3b5f 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_gnss.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
>> @@ -23,7 +23,7 @@ static void ice_gnss_read(struct kthread_work *work)
>>??????? struct ice_hw *hw;
>>??????? __be16 data_len_b;
>>??????? char *buf = NULL;
>> -???? u16 i, data_len;
>> +???? u32 i, data_len;
>
>Why does the length need to be specified at all, and no native types can
>be used?

I changed it to use native type. Length of the buffer is read from the device
and then used in a read loop.

Kind regards,
Karol

---------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173, 80-298 Gdansk
KRS 101882
NIP 957-07-52-316
