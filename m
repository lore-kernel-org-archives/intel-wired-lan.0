From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 07 Apr 2017 12:06:15 -0700
Subject: [Intel-wired-lan] [PATCH v2] igb: Allow to remove
 administratively set MAC on VFs
In-Reply-To: <20170405134622.12227-1-vinschen@redhat.com>
References: <CAKgT0UdHbfSL-5QM6sfH=j7adQLAscUss1GzN2oYZsLM1CgV3g@mail.gmail.com>
 <20170405134622.12227-1-vinschen@redhat.com>
Message-ID: <1491591975.39459.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2017-04-05 at 15:46 +0200, Corinna Vinschen wrote:
> ? Before libvirt modifies the MAC address and vlan tag for an SRIOV
> VF
> ? for use by a virtual machine (either using vfio device assignment
> or
> ? macvtap passthru mode), it saves the current MAC address and vlan
> tag
> ? so that it can reset them to their original value when the guest is
> ? done.? Libvirt can't leave the VF MAC set to the value used by the
> ? now-defunct guest since it may be started again later using a
> ? different VF, but it certainly shouldn't just pick any random
> value,
> ? either. So it saves the state of everything prior to using the VF,
> and
> ? resets it to that.
> 
> ? The igb driver initializes the MAC addresses of all VFs to
> ? 00:00:00:00:00:00, and reports that when asked (via an RTM_GETLINK
> ? netlink message, also visible in the list of VFs in the output of
> "ip
> ? link show"). But when libvirt attempts to restore the MAC address
> back
> ? to 00:00:00:00:00:00 (using an RTM_SETLINK netlink message) the
> kernel
> ? responds with "Invalid argument".
> 
> ? Forbidding a reset back to the original value leaves the VF MAC at
> the
> ? value set for the now-defunct virtual machine. Especially on a
> system
> ? with NetworkManager enabled, this has very bad consequences, since
> ? NetworkManager forces all interfacess to be IFF_UP all the time -
> if
> ? the same virtual machine is restarted using a different VF (or even
> on
> ? a different host), there will be multiple interfaces watching for
> ? traffic with the same MAC address.
> 
> ? To allow libvirt to revert to the original state, we need a way to
> ? remove the administrative set MAC on a VF, to allow normal host
> ? operation again, and to reset/overwrite the VF MAC via VF netdev.
> 
> ? This patch implements the outlined scenario by allowing to set the
> ? VF MAC to 00:00:00:00:00:00 via RTM_SETLINK on the PF.
> ? igb_ndo_set_vf_mac resets the IGB_VF_FLAG_PF_SET_MAC flag to 0,
> ? so it's possible to reset the VF MAC back to the original value via
> ? the VF netdev.
> 
> ? Note: Recent patches to libvirt allow for a workaround if the NIC
> ? isn't capable of resetting the administrative MAC back to all 0,
> but
> ? in theory the NIC should allow resetting the MAC in the first
> place.
> 
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> ---
> ?drivers/net/ethernet/intel/igb/igb_main.c | 42
> +++++++++++++++++++++++--------
> ?1 file changed, 31 insertions(+), 11 deletions(-)

This patch does not apply (not even close).  Please make sure to base
you patch off my dev-queue branch of my next-queue tree on kernel.org.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170407/33afc844/attachment.asc>
