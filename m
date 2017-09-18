From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 18 Sep 2017 17:03:47 +0000
Subject: [Intel-wired-lan] [PATCH v3 03/16] fm10k: avoid possible
 truncation	of q_vector->name
In-Reply-To: <20170710202319.22110-3-jacob.e.keller@intel.com>
References: <20170710202319.22110-1-jacob.e.keller@intel.com>
 <20170710202319.22110-3-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64AF661F@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 03/16] fm10k: avoid possible truncation of
> q_vector->name
> 
> New versions of GCC since version 7 began warning about possible
> truncation of calls to snprintf. We can fix this and avoid false
> positives. First, we should pass the full buffer size to snprintf,
> because it guarantees a NULL character as part of its passed length, so
> passing len-1 is simply wasting a byte of possible storage.
> 
> Second, if we make the ri and ti variables unsigned, the compiler is
> able to correctly reason that the value never gets larger than 256, so
> it doesn't need to warn about the full space required to print a signed
> integer.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

