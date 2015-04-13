From: David Miller <davem@davemloft.net>
Date: Mon, 13 Apr 2015 13:15:31 -0400 (EDT)
Subject: [Intel-wired-lan] [PATCH 0/2 net-next v2] Bring
 sizeof(net_device) down to < 2K bytes
In-Reply-To: <cover.1428672434.git.tgraf@suug.ch>
References: <cover.1428672434.git.tgraf@suug.ch>
Message-ID: <20150413.131531.1483293611941865421.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Thomas Graf <tgraf@suug.ch>
Date: Fri, 10 Apr 2015 15:52:36 +0200

> The size of struct net_device crossed the 2K boundary a while ago which
> is a waste in combination with many net namespaces. This series brings
> the size of struct net_device down to well below 2K in total size with
> a typical configuration. Some reserves a several holes leave room for
> further expansion.
> 
> Before:
> /* size: 2176, cachelines: 34, members: 121 */
> 
> After:
> /* size: 1984, cachelines: 31, members: 120 */

Series applied, thanks Thomas
