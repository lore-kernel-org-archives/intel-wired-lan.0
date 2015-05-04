From: David Miller <davem@davemloft.net>
Date: Mon, 04 May 2015 00:07:13 -0400 (EDT)
Subject: [Intel-wired-lan] [net PATCH 0/3] Clean-up some bits related to
	netpoll
In-Reply-To: <20150501173049.1029.54421.stgit@ahduyck-vm-fedora22>
References: <20150501173049.1029.54421.stgit@ahduyck-vm-fedora22>
Message-ID: <20150504.000713.94433995444786513.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Fri, 01 May 2015 10:34:32 -0700

> This patch set cleans up some minor items related to netpoll.  The first
> patch addresses an Rx clean-up bug that is triggered due to an assumption
> that napi->poll wouldn't be called with a budget of 0.  The other two
> patches address dev_kfree_skb being called in the xmit path which isn't
> valid since netpoll will call ndo_start_xmit with IRQs disabled.

Series applied, thanks Alex.
