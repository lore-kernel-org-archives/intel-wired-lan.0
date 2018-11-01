From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 1 Nov 2018 17:59:05 +0000
Subject: [Intel-wired-lan] [net-next 2/3] fm10k: ensure completer aborts
 are marked as non-fatal after a resume
In-Reply-To: <20181015191829.17115-3-jacob.e.keller@intel.com>
References: <20181015191829.17115-1-jacob.e.keller@intel.com>
 <20181015191829.17115-3-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E82A75883@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Jacob Keller
> Sent: Monday, October 15, 2018 12:18 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next 2/3] fm10k: ensure completer aborts are
> marked as non-fatal after a resume
> 
> VF drivers can trigger PCIe completer aborts any time they read a queue
> that they don't own. Even in nominal circumstances, it is not possible
> to prevent the VF driver from reading queues it doesn't own. VF drivers
> may attempt to read queues it previously owned, but which it no longer
> does due to a PF reset.
> 
> Normally these completer aborts aren't an issue. However, on some
> platforms these trigger machine check errors. This is true even if we
> lower their severity from fatal to non-fatal. Indeed, we already have
> code for lowering the severity.
> 
> We could attempt to mask these errors conditionally around resets, which
> is the most common time they would occur. However this would essentially
> be a race between the PF and VF drivers, and we may still occasionally
> see machine check exceptions on these strictly configured platforms.
> 
> Instead, mask the errors entirely any time we resume VFs. By doing so,
> we prevent the completer aborts from being sent to the parent PCIe
> device, and thus these strict platforms will not upgrade them into
> machine check errors.
> 
> Addtionally, we don't lose any information by masking these errors,
> because we'll still report VFs which attempt to access queues via the
> FUM_BAD_VF_QACCESS errors.
> 
> Without this change, on platforms where completer aborts cause machine
> check exceptions, the VF reading queues it doesn't own could crash the
> host system. Masking the completer abort prevents this, so we should
> mask it for good, and not just around a PCIe reset. Otherwise malicious
> or misconfigured VFs could cause the host system to crash.
> 
> Because we are masking the error entirely, there is little reason to
> also keep setting the severity bit, so that code is also removed.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>



