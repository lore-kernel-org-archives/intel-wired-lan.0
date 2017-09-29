From: wangyunjian <wangyunjian@huawei.com>
Date: Fri, 29 Sep 2017 09:13:25 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix limit imprecise of
 the number of MAC/VLAN that can be added for VFs
In-Reply-To: <CAKgT0UcsnLUWU8qedNrv+bhbgJ6SC9zWyc7oR9gObcYo2atN5g@mail.gmail.com>
References: <1506564064-10740-1-git-send-email-wangyunjian@huawei.com>
 <CAKgT0UcsnLUWU8qedNrv+bhbgJ6SC9zWyc7oR9gObcYo2atN5g@mail.gmail.com>
Message-ID: <34EFBCA9F01B0748BEB6B629CE643AE60C64BFF6@dggemm513-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Thursday, September 28, 2017 11:44 PM
> To: wangyunjian <wangyunjian@huawei.com>
> Cc: David Miller <davem@davemloft.net>; Jeff Kirsher
> <jeffrey.t.kirsher@intel.com>; Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com>; Netdev
> <netdev@vger.kernel.org>; caihe <caihe@huawei.com>; intel-wired-lan
> <intel-wired-lan@lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] [PATCH net v2] i40e: Fix limit imprecise of the
> number of MAC/VLAN that can be added for VFs
> 
> On Wed, Sep 27, 2017 at 7:01 PM, w00273186 <wangyunjian@huawei.com>
> wrote:
> > From: Yunjian Wang <wangyunjian@huawei.com>
> >
> > Now it doesn't limit the number of MAC/VLAN strictly. When there is more
> > elements in the virtchnl MAC/VLAN list, it can still add successfully.
> 
> You could still add but should you. I'm not clear from this patch
> description what this is supposed to be addressing. If you enable the
> "trust" flag for a VF via the "ip link set dev <iface> vf <vfnum>
> trust on" it can make use of any resources on the device, but without
> that there is an upper limit that is supposed to be enforced to
> prevent the VF from making use of an excessive amount of resources.
> That is what is being enforced by the code you are moving out of the
> way below.

I don't enable the "trust" flag for a VF. But this script can successfully add
MACs more than I40E_VC_MAX_MAC_ADDR_PER_VF(12) in VM. It has
same problem with VLAN.

Test script:

for((i=10;i<50;i++))
do
    ipmaddr add 01:00:5e:01:02:$i  dev eth0
done

for ((i=1;i<40;i++))
do
    ip link add link eth0 name eth0.$i type vlan id $i
done

> 
> > Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 27 +++++++++++++--
> -------
> >  1 file changed, 16 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> > index 4d1e670..285b96a 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> > @@ -2065,11 +2065,6 @@ static inline int i40e_check_vf_permission(struct
> i40e_vf *vf, u8 *macaddr)
> >                 dev_err(&pf->pdev->dev,
> >                         "VF attempting to override administratively set MAC address,
> reload the VF driver to resume normal operation\n");
> >                 ret = -EPERM;
> > -       } else if ((vf->num_mac >= I40E_VC_MAX_MAC_ADDR_PER_VF) &&
> > -                  !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
> > -               dev_err(&pf->pdev->dev,
> > -                       "VF is not trusted, switch the VF to trusted to add more
> functionality\n");
> > -               ret = -EPERM;
> >         }
> >         return ret;
> >  }
> > @@ -2128,6 +2123,15 @@ static int i40e_vc_add_mac_addr_msg(struct
> i40e_vf *vf, u8 *msg, u16 msglen)
> >                 } else {
> >                         vf->num_mac++;
> >                 }
> > +
> > +               if ((vf->num_mac >= I40E_VC_MAX_MAC_ADDR_PER_VF) &&
> > +                   !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
> > +                       dev_err(&pf->pdev->dev,
> > +                               "VF is not trusted, switch the VF to trusted to add more
> functionality\n");
> > +                       ret = -EPERM;
> > +                       spin_unlock_bh(&vsi->mac_filter_hash_lock);
> > +                       goto error_param;
> > +               }
> >         }
> >         spin_unlock_bh(&vsi->mac_filter_hash_lock);
> >
> 
> This doesn't make any sense. You are doing the checks after you have
> already added the MAC. The only part you aren't doing is sending the
> message to the VF indicating that the request was successful.
> 
> > @@ -2221,12 +2225,6 @@ static int i40e_vc_add_vlan_msg(struct i40e_vf
> *vf, u8 *msg, u16 msglen)
> >         i40e_status aq_ret = 0;
> >         int i;
> >
> > -       if ((vf->num_vlan >= I40E_VC_MAX_VLAN_PER_VF) &&
> > -           !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
> > -               dev_err(&pf->pdev->dev,
> > -                       "VF is not trusted, switch the VF to trusted to add more VLAN
> addresses\n");
> > -               goto error_param;
> > -       }
> >         if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
> >             !i40e_vc_isvalid_vsi_id(vf, vsi_id)) {
> >                 aq_ret = I40E_ERR_PARAM;
> > @@ -2269,6 +2267,13 @@ static int i40e_vc_add_vlan_msg(struct i40e_vf
> *vf, u8 *msg, u16 msglen)
> >                         dev_err(&pf->pdev->dev,
> >                                 "Unable to add VLAN filter %d for VF %d, error %d\n",
> >                                 vfl->vlan_id[i], vf->vf_id, ret);
> > +               if ((vf->num_vlan >= I40E_VC_MAX_VLAN_PER_VF) &&
> > +                   !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
> > +                       dev_err(&pf->pdev->dev,
> > +                               "VF is not trusted, switch the VF to trusted to add more
> VLAN addresses\n");
> > +                       aq_ret = -EPERM;
> > +                       goto error_param;
> > +               }
> >         }
> >
> >  error_param:
> 
> Same here. You are doing this after the call to i40e_vsi_add_vlan. The
> code makes no sense here. This bit of code is supposed to be
> preventing a VF from abusing resources if the VF is not privelaged.
