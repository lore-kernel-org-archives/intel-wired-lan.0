From: Lan Tianyu <tianyu.lan@intel.com>
Date: Mon, 26 Oct 2015 13:36:09 +0800
Subject: [Intel-wired-lan] [RFC Patch 00/12] IXGBE: Add live migration
 support for SRIOV NIC
In-Reply-To: <562A7E33.4080800@gmail.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <562A7E33.4080800@gmail.com>
Message-ID: <562DBBC9.4000104@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2015?10?24? 02:36, Alexander Duyck wrote:
> I was thinking about it and I am pretty sure the dummy write approach is
> problematic at best.  Specifically the issue is that while you are
> performing a dummy write you risk pulling in descriptors for data that
> hasn't been dummy written to yet.  So when you resume and restore your
> descriptors you will have once that may contain Rx descriptors
> indicating they contain data when after the migration they don't.

How about changing sequence? dummy writing Rx packet data fist and then
its desc. This can ensure that RX data is migrated before its desc and
prevent such case.

-- 
Best regards
Tianyu Lan
