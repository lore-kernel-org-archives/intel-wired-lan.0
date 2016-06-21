From: David Miller <davem@davemloft.net>
Date: Tue, 21 Jun 2016 04:34:31 -0400 (EDT)
Subject: [Intel-wired-lan] [net-next PATCH v3 00/17] Future-proof tunnel
	offload handlers
In-Reply-To: <34f19f9c-221b-78f0-3989-9384e0d22e54@redhat.com>
References: <20160617.202641.1821023739498595024.davem@davemloft.net>
 <CALx6S34Y3Qq6nMHuMcC2LC5duLBO3KVN3+A+0qmPrNvFfY7gJg@mail.gmail.com>
 <34f19f9c-221b-78f0-3989-9384e0d22e54@redhat.com>
Message-ID: <20160621.043431.177352816188322653.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Hannes Frederic Sowa <hannes@redhat.com>
Date: Mon, 20 Jun 2016 11:11:32 -0700

> I am not sure if this is necessary. The devices actually having the
> ndo-ops, used to configure offloading, should only be visible inside one
> namespace. If those ndo-ops actually have side effects on other
> namespaces, they violate the contract and should be removed from the
> driver. :/

This is most if not all drivers right now, to the best of my
understanding.
