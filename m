From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 07 Aug 2018 10:52:17 -0700
Subject: [Intel-wired-lan] [PATCH v6 5/9] fm10k: Do not call
 pcie_print_link_status()
In-Reply-To: <20180806232600.25694-5-mr.nuke.me@gmail.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
 <20180806232600.25694-1-mr.nuke.me@gmail.com>
 <20180806232600.25694-5-mr.nuke.me@gmail.com>
Message-ID: <263e783d8aa8b50c27d8919d178066367162488e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2018-08-06 at 18:25 -0500, Alexandru Gagniuc wrote:
> This is now done by the PCI core to warn of sub-optimal bandwidth.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180807/d4ce42cf/attachment.asc>
