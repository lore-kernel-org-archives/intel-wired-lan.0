From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 18 Sep 2017 17:02:45 +0000
Subject: [Intel-wired-lan] [PATCH v3 02/16] fm10k: fix typos on fall
 through	comments
In-Reply-To: <20170710202319.22110-2-jacob.e.keller@intel.com>
References: <20170710202319.22110-1-jacob.e.keller@intel.com>
 <20170710202319.22110-2-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64AF65EE@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 02/16] fm10k: fix typos on fall through
> comments
> 
> Newer versions of GCC since version 7 now warn when a case statement may
> fall through without an explicit comment. "Fallthough" does not count as
> it is misspelled. Fix the typos for these comments to appease the new
> warnings.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

