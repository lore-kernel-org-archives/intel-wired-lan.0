From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 19 Jun 2015 02:15:56 -0700
Subject: [Intel-wired-lan] [PATCH v2] fm10k: Report MAC address on
	driver load
In-Reply-To: <20150619023812.1345.75383.stgit@ahduyck-vm-fedora22>
References: <20150619023812.1345.75383.stgit@ahduyck-vm-fedora22>
Message-ID: <1434705356.3530.82.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-06-18 at 19:41 -0700, Alexander Duyck wrote:
> This change adds the MAC address to the list of values recorded on
> driver
> load.  The MAC address represents the serial number of the unit and
> allows
> us to track the value should a card be replaced in a system.
> 
> The log message should now be similar in output to that of ixgbe.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
> ---
> 
> v2: Moved printing of MAC onto separate line similar to ixgbe.
> 
> (Hopefully this works for you Jeff.  I took at look at the patch and
> just
>  moved the bit I needed down.  I figured since this block hasn't
> changed I
>  should be able to get away with just doing this instead of pulling
> and
>  rebasing off of your tree. )
> 
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c |    3 +++
>  1 file changed, 3 insertions(+)

Works for me!  I have added your updated patch to my queue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150619/c8675f84/attachment.asc>
