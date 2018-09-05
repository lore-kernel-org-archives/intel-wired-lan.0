From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 5 Sep 2018 08:26:05 +0100
Subject: [Intel-wired-lan] [PATCH 1/9] PCI: sysfs: Export available PCIe
 bandwidth
In-Reply-To: <20180903180242.14504-2-mr.nuke.me@gmail.com>
References: <20180903180242.14504-1-mr.nuke.me@gmail.com>
 <20180903180242.14504-2-mr.nuke.me@gmail.com>
Message-ID: <20180905082605.69d9e5a0@shemminger-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon,  3 Sep 2018 13:02:28 -0500
Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:

> For certain bandwidth-critical devices (e.g. multi-port network cards)
> it is useful to know the available bandwidth to the root complex. This
> information is only available via the system log, which doesn't
> account for link degradation after probing.
> 
> With a sysfs attribute, we can computes the bandwidth on-demand, and
> will detect degraded links.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

In other places (like /sys/class/net/eth0/speed) only the raw value is printed
without suffix.  The general convention in sysfs is that it should be one value
per file and in more raw format.  So why not just print it in bits/sec without
suffix?
