From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Apr 2015 17:01:52 -0700
Subject: [Intel-wired-lan] [PATCH 0/3 net-next] Bring sizeof(net_device)
	down to < 2K bytes
In-Reply-To: <cover.1428622095.git.tgraf@suug.ch>
References: <cover.1428622095.git.tgraf@suug.ch>
Message-ID: <20150410000151.GA1728@Alexeis-MBP.westell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Apr 10, 2015 at 01:43:25AM +0200, Thomas Graf wrote:
> The size of struct net_device crossed the 2K boundary a while ago which
> is a waste in combination with many net namespaces. This series brings
> the size of struct net_device down to well below 2K in total size with
> a typical configuration. Some reserves a several holes leave room for
> further expansion.

Great stuff!
Can you share what was the sizeof(struct net_device) with typical
x86 config before and after?

