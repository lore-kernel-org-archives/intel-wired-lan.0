From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 27 Sep 2018 16:19:54 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Use proper enum in
 i40e_ndo_set_vf_link_state
In-Reply-To: <20180921101359.23911-1-natechancellor@gmail.com>
References: <20180921101359.23911-1-natechancellor@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC890@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Nathan Chancellor
> Sent: Friday, September 21, 2018 3:14 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> <davem@davemloft.net>
> Cc: netdev at vger.kernel.org; Nathan Chancellor
> <natechancellor@gmail.com>; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Use proper enum in
> i40e_ndo_set_vf_link_state
> 
> Clang warns when one enumerated type is converted implicitly to another.
> 
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:4214:42: warning:
> implicit conversion from enumeration type 'enum i40e_aq_link_speed' to
> different enumeration type 'enum virtchnl_link_speed'
>       [-Wenum-conversion]
>                 pfe.event_data.link_event.link_speed = I40E_LINK_SPEED_40GB;
>                                                      ~ ^~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
> 
> Use the proper enum from virtchnl_link_speed, which has the same value as
> I40E_LINK_SPEED_40GB, VIRTCHNL_LINK_SPEED_40GB. This appears to be
> missed by commit ff3f4cc267f6 ("virtchnl: finish conversion to virtchnl
> interface").
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/81
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


