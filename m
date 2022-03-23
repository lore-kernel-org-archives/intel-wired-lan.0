From: Ivan Vecera <ivecera@redhat.com>
Date: Wed, 23 Mar 2022 18:54:26 +0100
Subject: [Intel-wired-lan] [PATCH net] ice: Clear default forwarding VSI
 during VSI release
In-Reply-To: <45b155ff-8e26-fa96-f89e-6a561de01abb@linux.intel.com>
References: <20220322142554.3253428-1-ivecera@redhat.com>
 <45b155ff-8e26-fa96-f89e-6a561de01abb@linux.intel.com>
Message-ID: <20220323185426.33c66892@ceranb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 23 Mar 2022 18:39:11 +0100
Marcin Szycik <marcin.szycik@linux.intel.com> wrote:

> On 22-Mar-22 15:25, Ivan Vecera wrote:
> > VSI is set as default forwarding one when promisc mode is set for
> > PF interface, when PF is switched to switchdev mode or when VF
> > driver asks to enable allmulticast or promisc mode for the VF
> > interface (when vf-true-promisc-support priv flag is off).
> > The third case is buggy because in that case VSI associated with
> > VF remains as default one after VF removal.
> > 
> > Reproducer:
> > 1. Create VF
> >    echo 1 > sys/class/net/ens7f0/device/sriov_numvfs
> > 2. Enable allmulticast or promisc mode on VF
> >    ip link set ens7f0v0 allmulticast on
> >    ip link set ens7f0v0 promisc on
> > 3. Delete VF
> >    echo 0 > sys/class/net/ens7f0/device/sriov_numvfs
> > 4. Try to enable promisc mode on PF
> >    ip link set ens7f0 promisc on
> > 
> > Although it looks that promisc mode on PF is enabled the opposite
> > is true because ice_vsi_sync_fltr() responsible for IFF_PROMISC
> > handling first checks if any other VSI is set as default forwarding
> > one and if so the function does not do anything. At this point
> > it is not possible to enable promisc mode on PF without re-probe
> > device.
> > 
> > To resolve the issue this patch clear default forwarding VSI
> > during ice_vsi_release() when the VSI to be released is the default
> > one.
> > 
> > Fixes: 01b5e89aab49 ("ice: Add VF promiscuous support")
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_lib.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index 53256aca27c7..20d755822d43 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -3147,6 +3147,8 @@ int ice_vsi_release(struct ice_vsi *vsi)
> >  		}
> >  	}
> >  
> > +	if (ice_is_vsi_dflt_vsi(pf->first_sw, vsi))
> > +		ice_clear_dflt_vsi(pf->first_sw);  
> 
> It would probably be good to check `ice_clear_dflt_vsi` return code.

Check and report potential warning when error occurs? because we are in ice_vsi_release() so
any rollback does not make sense.

Ivan

