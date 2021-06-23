From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Wed, 23 Jun 2021 15:43:16 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2] ice: Enable configuration
 of number of qps per VF via devlink
In-Reply-To: <DM6PR11MB32913145E3D57435455C206893089@DM6PR11MB3291.namprd11.prod.outlook.com>
References: <20210426181940.14847-1-sridhar.samudrala@intel.com>
 <CO1PR11MB48359F4AB09484353280CBA9F52D9@CO1PR11MB4835.namprd11.prod.outlook.com>
 <c78efee5-d864-7903-98b5-207aadae19fa@intel.com>
 <DM6PR11MB32913145E3D57435455C206893089@DM6PR11MB3291.namprd11.prod.outlook.com>
Message-ID: <31788b56-c3aa-f17f-b788-8a0f3129ad4e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/23/2021 3:15 PM, Singhai, Anjali wrote:
> Sridhar, how do you do asymmetric number of queues and vectors to the VF using devlink? Or this ends up as a configuration on VF representors... I hope not.
>
> So I am guessing you can either bulk set the number of queues for each of the VFs or you can set it per SRIOV VF ports?

This is first step in a series of patches to make VF resources configurable.
The next step is to enable creating a devlink port for each VF and 
support port specific parameters
via the devlink port.
Then we can enable changing the queue pairs or msix-vectors for a 
specific instance of a VF
before it is activated rather? than all VFs having equal number of 
resources.

>
> Thanks
> Anjali
>
> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Samudrala, Sridhar
> Sent: Wednesday, June 23, 2021 9:21 AM
> To: Creeley, Brett <brett.creeley@intel.com>; intel-wired-lan at lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Ismail, Mustafa <mustafa.ismail@intel.com>; Saleem, Shiraz <shiraz.saleem@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH net-next v2] ice: Enable configuration of number of qps per VF via devlink
>
> On 5/17/2021 2:49 PM, Creeley, Brett wrote:
>>> -----Original Message-----
>>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>>> Of Sridhar Samudrala
>>> Sent: Monday, April 26, 2021 11:20 AM
>>> To: intel-wired-lan at lists.osuosl.org; Nguyen, Anthony L
>>> <anthony.l.nguyen@intel.com>; Samudrala, Sridhar
>>> <sridhar.samudrala@intel.com>
>>> Subject: [Intel-wired-lan] [PATCH net-next v2] ice: Enable
>>> configuration of number of qps per VF via devlink
>>>
>>> Introduce a devlink parameter 'num_qps_per_vf' to allow user to
>>> configure the maximum number of queue pairs given to SR-IOV VFs
>>> before they are created.
>>>
>>> This is currently determined by the driver based on the number of
>>> SR-IOV VFs created. In order to keep this behavior by default the
>>> parameter is initialized to 0. To change the default behavior, user
>>> can set num_qps_per_vf parameter via devlink and this will be used as
>>> the preferred value to determine the queues and vectors assigned per
>>> VF.
>> What if the host administrator wants to give the VF a different number
>> of vectors than queues? For example, if the admin knows the VF
>> instance will be exercising VF RDMA and the VF needs more vectors for
>> RDMA traffic.
>>
>> Should we have 2 separate values, i.e. "num_qps_per_vf" and
>> "num_msix_per_vf"?
> I missed responding to this comment.
> Sure. We can add num_msix_pr_vf as a later patch to enable additional vectors for RDMA.
>
> Tony,
> Can this patch be included in your series when you submit to netdev?
> OR do i need to rebase it based on the latest net-next?
>
> Thanks
> Sridhar
>>> USAGE:
>>> On a 2 port NIC
>>>    # devlink dev param show
>>>    pci/0000:42:00.0:
>>>      name num_qps_per_vf type driver-specific
>>>        values:
>>>          cmode runtime value 0
>>>    pci/0000:42:00.1:
>>>      name num_qps_per_vf type driver-specific
>>>        values:
>>>          cmode runtime value 0
>>>
>>>    /* Set num_qps_per_vf to 4 */
>>>    # devlink dev param set pci/0000:42:00.0 name num_qps_per_vf value
>>> 4 cmode runtime
>>>
>>>    # devlink dev param show pci/0000:42:00.0 name num_qps_per_vf
>>>    pci/0000:42:00.0:
>>>      name num_qps_per_vf type driver-specific
>>>        values:
>>>          cmode runtime value 4
>>>
>>>    # echo 8 > /sys/class/net/enp66s0f0/device/sriov_numvfs
>>>
>>> This will create 8 VFs with 4 queue pairs and 5 vectors per VF
>>> compared to the default behavior of 16 queue pairs and 17 vectors per
>>> VF.
>>>
>>> v2:
>>> Fixed kdoc for ice_devlink_num_qps_per_vf_validate()
>>>
>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>> ---
>>>    Documentation/networking/devlink/ice.rst      |  23 ++++
>>>    drivers/net/ethernet/intel/ice/ice_devlink.c  | 110 +++++++++++++++++-
>>>    drivers/net/ethernet/intel/ice/ice_main.c     |   3 +
>>>    .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   5 +-
>>>    4 files changed, 139 insertions(+), 2 deletions(-)
>>>
>> <snip>
>>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

