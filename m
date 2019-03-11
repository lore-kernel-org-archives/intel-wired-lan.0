From: David Miller <davem@davemloft.net>
Date: Mon, 11 Mar 2019 13:38:26 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH] net: fm10k: fix a potential NULL
 pointer dereference
In-Reply-To: <20190311061732.19064-1-kjlu@umn.edu>
References: <20190311061732.19064-1-kjlu@umn.edu>
Message-ID: <20190311.133826.1956424437446816552.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kangjie Lu <kjlu@umn.edu>
Date: Mon, 11 Mar 2019 01:17:32 -0500

> In case alloc_workqueue fails, the fix returns -ENOMEM to avoid
> potential NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Jeff, I assume you will pick this up.

Thank you.
