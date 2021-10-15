From: Drewek, Wojciech <wojciech.drewek@intel.com>
Date: Fri, 15 Oct 2021 08:37:18 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Forbid trusted VFs in
 switchdev mode
In-Reply-To: <456e1efa-c48d-df56-5372-91db6e33e6f9@intel.com>
References: <20211014160958.238689-1-wojciech.drewek@intel.com>
 <456e1efa-c48d-df56-5372-91db6e33e6f9@intel.com>
Message-ID: <MN2PR11MB47114907218CBAF8F4E1D0FAFDB99@MN2PR11MB4711.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Sent: czwartek, 14 pa?dziernika 2021 20:16
> To: Drewek, Wojciech <wojciech.drewek@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: Forbid trusted VFs in switchdev mode
> 
> On 10/14/2021 9:09 AM, Wojciech Drewek wrote:
> > During auto-merge, check for switchdev mode has been inserted
> > in wrong place. It should be in ice_set_vf_trust not in ice_set_vf_mac.
> >
> > Trusted VFs are forbidden in switchdev mode because they should
> > be configured only from the host side.
> >
> 
> should have had
> Fixes: 1c54c839935b ("ice: enable/disable switchdev when managing VFs")
I've added tag in the second version
> 
> 
> > Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> > index 3e7fdd7f2e1d..edbc417f8c7d 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> > @@ -4815,11 +4815,6 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
> >   	struct ice_vf *vf;
> >   	int ret;
> >
> > -	if (ice_is_eswitch_mode_switchdev(pf)) {
> > -		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in switchdev mode\n");
> > -		return -EOPNOTSUPP;
> > -	}
> > -
> >   	if (ice_validate_vf_id(pf, vf_id))
> >   		return -EINVAL;
> >
> > @@ -4882,6 +4877,11 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
> >   	struct ice_vf *vf;
> >   	int ret;
> >
> > +	if (ice_is_eswitch_mode_switchdev(pf)) {
> > +		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in switchdev mode\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> >   	if (ice_validate_vf_id(pf, vf_id))
> >   		return -EINVAL;
> >
> >

