From: Jonathan Toppins <jtoppins@redhat.com>
Date: Fri, 17 Dec 2021 11:17:38 -0500
Subject: [Intel-wired-lan] [v2,intel-next] ice: Fix E810 PTP reset flow
In-Reply-To: <CADEbmW0Yu2Csd++EZG--S+t2PEveB5PbUrooGdYnpumEqxF5Xg@mail.gmail.com>
References: <b0f0513b-2ab6-7703-9b5d-65c6763f4bd5@redhat.com>
 <CADEbmW0Yu2Csd++EZG--S+t2PEveB5PbUrooGdYnpumEqxF5Xg@mail.gmail.com>
Message-ID: <895a4199-4228-04c7-4f60-d782415017f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/17/21 11:08, Michal Schmidt wrote:
> On Fri, Dec 17, 2021 at 4:31 PM Jonathan Toppins <jtoppins@redhat.com>
> wrote:
> 
>> I am not on the intel wired lan email list so I do not have an email to
>> reply to directly
>>
> 
> Jon,
> please subscribe to it, via this page:
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
>> b/drivers/net/ethernet/intel/ice/ice_main.c
>> index a3ce54a78859..dc1c3d8e7272 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> [...]
>> @@ -6737,6 +6737,9 @@  static void ice_rebuild(struct ice_pf *pf, enum
>> ice_reset_req reset_type)
>>                  goto err_vsi_rebuild;
>>          }
>>
>> +       /* configure PTP timestamping after VSI rebuild */
>> +               ice_ptp_cfg_timestamp(pf, false);
>> +
>>          err = ice_vsi_rebuild_by_type(pf, ICE_VSI_SWITCHDEV_CTRL);
>>          if (err) {
>>                  dev_err(dev, "Switchdev CTRL VSI rebuild failed: %d\n",
>> err);
>>
>> [jtoppins]
>> The indention here looks incorrect and implies the call should be inside
>> an if-statement. Is this placed in the correct location?
>>
>> -Jon
>>
> 
> Also, isn't it strange that the second argument to ice_ptp_cfg_timestamp()
> is always "false" everywhere the function is called?
> 

Yes it is but that was added with upstream commit 77a781155a65 ("ice: 
enable receive hardware timestamping"), I would rather not muddy the 
patch with fixing this too. That should be another patch to remove the 
useless parameter list argument.

-Jon

