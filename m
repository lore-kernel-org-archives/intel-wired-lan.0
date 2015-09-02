From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:00:25 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: Don't assume page fragments
 are	page size
In-Reply-To: <20150616184712.1966.44790.stgit@ahduyck-vm-fedora22>
References: <20150616184712.1966.44790.stgit@ahduyck-vm-fedora22>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B5379@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Alexander Duyck
Sent: Tuesday, June 16, 2015 11:47 AM
To: netdev@vger.kernel.org; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Subject: [Intel-wired-lan] [PATCH] fm10k: Don't assume page fragments are page size

This change pulls out the optimization that assumed that all fragments would be limited to page size.  That hasn't been the case for some time now and to assume this is incorrect as the TCP allocator can provide up to a 32K page fragment.

Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
---
 
Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
