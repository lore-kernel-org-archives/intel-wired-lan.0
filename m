From: Hannes Frederic Sowa <hannes@redhat.com>
Date: Tue, 21 Jun 2016 08:23:50 -0700
Subject: [Intel-wired-lan] [net-next PATCH v3 00/17] Future-proof tunnel
	offload handlers
In-Reply-To: <20160621.042211.945844554759834352.davem@davemloft.net>
References: <20160616191851.20872.67154.stgit@localhost.localdomain>
 <20160617.202641.1821023739498595024.davem@davemloft.net>
 <CALx6S34Y3Qq6nMHuMcC2LC5duLBO3KVN3+A+0qmPrNvFfY7gJg@mail.gmail.com>
 <20160621.042211.945844554759834352.davem@davemloft.net>
Message-ID: <4420aeb6-23c0-4f9b-d1c2-e7adf9d17f2c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 21.06.2016 01:22, David Miller wrote:
> From: Tom Herbert <tom@herbertland.com>
> Date: Mon, 20 Jun 2016 10:05:01 -0700
> 
>> Generally, this means it needs to at least match by local addresses
>> and port for an unconnected/unbound socket, the source address for
>> an unconnected/bound socket, a the full 4-tuple for a connected
>> socket.
> 
> These lookup keys are all insufficient.
> 
> At the very least the network namespace must be in the lookup key as
> well if you want to match "sockets".  And this is just the tip of the
> iceberg in my opinion.
> 
> The namespace bypassing to me is the biggest flaw in the UDP tunnel
> offloads.  That is creating real dangers right now.
> 
> But anyways, the vastness of the key is why we want to keep "sockets"
> out of network cards, because proper support of "sockets" requires
> access to information the card simply does not and should not have.

We can't look up UDP sockets without having the namespace. We inherit
the namespace from the device the packet showed up on. So I think in
regards to namespaces this looks more or less fine.

Not being able to match on the destination ip or even not considering
the routing infrastructure is kind of dangerous (e.g. we might want to
make the socket not reachable from an interface via ip rules or
blackhole routes, but they wouldn't be considered, too).

Bye,
Hannes

