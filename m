From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 23 Jun 2016 23:25:00 +0000
Subject: [Intel-wired-lan] [PATCH v2 08/18] fm10k: split fm10k_reinit
 into	two functions
In-Reply-To: <20160607230902.5457-9-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
 <20160607230902.5457-9-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27397EFB@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 7, 2016 4:09 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2 08/18] fm10k: split fm10k_reinit into two functions

There are several flows in the driver which perform the similar function of tearing down software and restoring software to recover from certain errors or PCIe events, including:

  * fm10k_reinit
  * fm10k_suspend/resume
  * fm10k_io_error_detected/fm10k_io_resume

In addition, we want to implement a .reset_notify() handler as well which will also perform similar function.

Rework how the driver codes reset and resume flows by separating out the reinit logic into two functions "fm10k_prepare_for_reset" and "fm10k_handle_reset". This first step will allow us to re-use this functionality in the similar blocks of code instead of re-coding the same sequence of events slightly different.

The end result should be more maintainable and correct, fixing several inconsistencies with the work flow.

The new functions expect to take the rtnl_lock() themselves, and it does have the unfortunate side effect of having the reinit flow take then release then take the rtnl_lock. However, this minor downside is outweighted by the benefits of code reduction and reducing needless difference between these flows.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>



