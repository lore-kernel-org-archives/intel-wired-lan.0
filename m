From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 22 Jun 2016 22:24:50 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k: don't continue probe if PCI
 device not in normal IO state
In-Reply-To: <20160614232616.27686-1-jacob.e.keller@intel.com>
References: <20160614232616.27686-1-jacob.e.keller@intel.com>
Message-ID: <1466659490.2692.6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-06-14 at 16:26 -0700, Jacob Keller wrote:
> In the event of an uncorrectable AER error occuring when the driver has
> not loaded, the recovery routines are not done. This is done because
> future loads of the driver may not be aware of the IO state and may not
> be able to recover at all. In this case, when we next load the driver it
> fails due to what appears to be a surprise remove event. Instead, add
> a check to ensure that the device is in the normal IO state before
> continuing to probe. This allows us to give a more descriptive message
> of what is wrong.
> 
> Without this change, the driver will attempt to probe up to our first
> call of .reset_hw() which will be unable to read registers and act as if
> a surprise remove event occurred.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> ?drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 6 ++++++
> ?1 file changed, 6 insertions(+)

This does not apply at all, the code was already removed in a previous
patch. ?So I am dropping this patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160622/926489df/attachment.asc>
