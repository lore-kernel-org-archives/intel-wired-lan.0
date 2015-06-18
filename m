From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 18 Jun 2015 15:49:35 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: Report MAC address on driver
	load
In-Reply-To: <20150618031252.15654.56639.stgit@ahduyck-vm-fedora22>
References: <20150618031252.15654.56639.stgit@ahduyck-vm-fedora22>
Message-ID: <1434667775.3530.79.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-06-17 at 20:12 -0700, Alexander Duyck wrote:
> This change adds the MAC address to the list of values recorded on
> driver
> load.  The MAC address represents the serial number of the unit and
> allows
> us to track the value should a card be replaced in a system.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks Alex, I will get this added to my queue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150618/33f34292/attachment.asc>
