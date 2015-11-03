From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 03 Nov 2015 04:38:51 -0800
Subject: [Intel-wired-lan] [next PATCH 00/11] ixgbe: Add support for
 mixed PF/VF virtualization
In-Reply-To: <20151103005850.28233.63113.stgit@localhost.localdomain>
References: <20151103005850.28233.63113.stgit@localhost.localdomain>
Message-ID: <1446554331.12325.0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-11-02 at 17:09 -0800, Alexander Duyck wrote:
> This patch series extends the abilities of the ixgbe driver so that
> we can
> now support VLAN trunking on top of the PF when SR-IOV is enabled. 
> By
> doing this we are able to extend the existing capabilities that were
> enabled with the "bridge fdb add" support that was added some time
> ago.  It
> had enabled the ability to have PF and VF mixed on a flat network,
> this
> makes it so that it also works on a VLAN enabled network.
> 
> The first few patches in this series are basically just cleanup. 
> They
> either fix bugs found in the code, or address complexity that was
> making it
> hard to either read or sort out exactly how the code was supposed to
> work.
> 
> The second half of the patch set is where we start adding features.
> Specifically with this patch set the VLAN behavior changes for the PF
> in
> two ways.  First we do not need to use the VLVF if the VFs have not
> already
> set up a pool list.  As such I added functionality so that we can
> skip that
> step when it is not needed.  Then I added support for VLAN
> promiscuous by
> simply setting all of the bits in the VFTA and letting the packets
> fall
> through to the default pool.  In addition when in promiscuous mode we
> set
> the pool bit for the PF in all of the VLVF entries.  This way if
> anyone
> adds a new entry it will automatically have the PF enabled.
> 
> The last few patches address some more issues I found during testing.
>   The
> issues were primarily related to stale entries floating around in
> either
> the RAR or VLVFB registers which were pointing to pools which were
> not
> valid for the given L2 address.

I have added these patches to my queue, Dave.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151103/1fa1ab25/attachment.asc>
