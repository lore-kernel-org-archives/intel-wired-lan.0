From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 18 Sep 2017 17:11:50 +0000
Subject: [Intel-wired-lan] [PATCH v3 07/16] fm10k: don't loop
	while	resetting VFs due to VFLR event
In-Reply-To: <20170710202319.22110-7-jacob.e.keller@intel.com>
References: <20170710202319.22110-1-jacob.e.keller@intel.com>
 <20170710202319.22110-7-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64AF66CD@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Jacob Keller
> Sent: Monday, July 10, 2017 1:23 PM
> To: jtkirhse at osuosl.org; Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: jekeller at osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 07/16] fm10k: don't loop while resetting
> VFs due to VFLR event
> 
> We've always had a really weird looping construction for resetting VFs.
> We read the VFLRE register and reset the VF if the corresponding bit is
> set, which makes sense. However we loop continuously until we no longer
> have any bits left unset. At first this makes sense, as a sort of "keep
> trying until we succeed" concept.
> 
> Unfortunately this causes a problem if we happen to surprise remove
> while this code is executing, because in this case we'll always read all
> 1s for the VFLRE register. This results in a hard lockup on the CPU
> because the loop will never terminate.
> 
> Because our own reset function will clear the VFLR event register
> always, (except when we've lost PCIe link obviously) there is no real
> reason to loop. In practice, we'll loop over once and find that no VFs
> are pending anymore.
> 
> Lets just check once. Since we're clear the notification when we reset
> there's no benefit to the loop. Additionally, there shouldn't be a race
> as future VLFRE events should trigger an interrupt. Additionally, we
> didn't warn or do anything in the looped case anyways.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

