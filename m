From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 30 Aug 2016 16:15:13 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] fm10k: napi polling routine
	must	return actual work done
In-Reply-To: <20160620173933.5638-1-jacob.e.keller@intel.com>
References: <20160620173933.5638-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273BF2B7@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Monday, June 20, 2016 10:40 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Paolo Abeni <pabeni@redhat.com>; Alexander Duyck <aduyck@mirantis.com>; Venkatesh Srinivas <venkateshs@google.com>
Subject: [Intel-wired-lan] [PATCH 1/2] fm10k: napi polling routine must return actual work done

When fm10k_poll fully cleans rings it returns 0. This is incorrect as it messes up the budget accounting in the core napi code. Fix this by returning actual work done, capped at budget - 1 since the core doesn't expect a return of the full budget when the driver modifies the napi status.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Venkatesh Srinivas <venkateshs@google.com>
Cc: Alexander Duyck <aduyck@mirantis.com>
---
 
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

