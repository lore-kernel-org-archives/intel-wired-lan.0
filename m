From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 21 Jun 2016 10:05:08 -0700
Subject: [Intel-wired-lan] [net-next PATCH v3 00/17] Future-proof tunnel
	offload handlers
In-Reply-To: <20160621.042211.945844554759834352.davem@davemloft.net>
References: <20160616191851.20872.67154.stgit@localhost.localdomain>
 <20160617.202641.1821023739498595024.davem@davemloft.net>
 <CALx6S34Y3Qq6nMHuMcC2LC5duLBO3KVN3+A+0qmPrNvFfY7gJg@mail.gmail.com>
 <20160621.042211.945844554759834352.davem@davemloft.net>
Message-ID: <CAKgT0Ucze-+PYdvoHhDSLuaTLrn+Ene+CnfJaKO7AEHGHBsKzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jun 21, 2016 at 1:22 AM, David Miller <davem@davemloft.net> wrote:
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

I agree.  Fortunately this only really becomes an issue if SR-IOV is
enabled.  Otherwise the port based offloads only affect the PF as long
as no VFs are present.

> But anyways, the vastness of the key is why we want to keep "sockets"
> out of network cards, because proper support of "sockets" requires
> access to information the card simply does not and should not have.

Right.  Really what I would like to see for most of these devices is a
2 tuple filter where you specify the UDP port number, and the PF/VF ID
that the traffic is received on.  In order to get that we wouldn't
need any additional information from the API.  Then we at least have
indirect namespace isolation, and if someone really wanted to they
could do offloads on the VFs for different traffic.
