From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 18 Sep 2017 17:07:45 +0000
Subject: [Intel-wired-lan] [PATCH v3 05/16] fm10k: avoid needless delay
 when	loading driver
In-Reply-To: <20170710202319.22110-5-jacob.e.keller@intel.com>
References: <20170710202319.22110-1-jacob.e.keller@intel.com>
 <20170710202319.22110-5-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64AF6662@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 05/16] fm10k: avoid needless delay when
> loading driver
> 
> When we load the driver, we set the last_reset to be in the future,
> which delays the initial driver reset. Additionally, the service task
> isn't scheduled to run automatically until the timer runs out. This
> causes a needless delay of the first reset to begin talking to the
> switch manager.
> 
> We can avoid this by simply not setting last_reset and immediately
> scheduling the service task while in probe. This allows the device to
> wake up faster, and avoids this delay.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

