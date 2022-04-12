From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 12 Apr 2022 10:35:54 -0700
Subject: [Intel-wired-lan] [PATCH net-next 2/6] ice: always check VF VSI
 pointer values
In-Reply-To: <e079ab74-48fc-65d1-4d3f-2c0cdd4ffcb9@molgen.mpg.de>
References: <20220411232907.1022602-1-jacob.e.keller@intel.com>
 <20220411232907.1022602-3-jacob.e.keller@intel.com>
 <e079ab74-48fc-65d1-4d3f-2c0cdd4ffcb9@molgen.mpg.de>
Message-ID: <987480f6-9fc1-bd67-8803-9b88645b514c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 4/11/2022 10:38 PM, Paul Menzel wrote:
> Dear Jacob,
> 
> 
> Thank you for the patch.
> 
> Am 12.04.22 um 01:29 schrieb Jacob Keller:
>> The ice_get_vf_vsi function can return NULL in some cases, such as if
>> handling messages during a reset where the VSI is being removed and
>> recreated.
>>
>> Several places throughout the driver do not bother to check whether this
>> VSI pointer is valid. Static analysis tools maybe report issues because
>> they detect paths where a potentially NULL pointer could be
>> dereferenced.
> 
> (side note: scripts/checkpatch.pl checks for 75 characters per line, and 
> you seem to use 72 characters per line.)
> 

For commit message wrapping? I use some default from a vim plugin which
I guess decided that 72 was a good choice. Technically thats 8
characters less than 80 which is one full tabstop if you render tabs as
8 spaces, which is sometimes used as a method of indenting commits from
git tools..

>> Fix this by checking the return value of ice_get_vf_vsi everywhere.
> 
> I didn?t understand, when WARN_ON() is necessary, and when not, but 
> looks fine.
> 

I tried my best to use WARN_ON in places which have no suitable way to
report an error back out, but for places where we can simply fail the
operation I avoided it.

This was similar to how we handled invalid VF pointers in certain places.

The WARN_ONs aren't strictly needed, but generally speaking those flows
shouldn't be hitting an invalid pointer. (Indeed, prior to this patch
they would have been BUGs instead!)

Hope that explains why not every place has the WARN_ON.

>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_devlink.c  |  5 ++-
>>   drivers/net/ethernet/intel/ice/ice_repr.c     |  7 +++-
>>   drivers/net/ethernet/intel/ice/ice_sriov.c    | 32 +++++++++++++++++--
>>   drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 28 +++++++++++++++-
>>   drivers/net/ethernet/intel/ice/ice_virtchnl.c |  5 +++
>>   .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  7 +++-
>>   6 files changed, 77 insertions(+), 7 deletions(-)
> 
> [?]
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul
