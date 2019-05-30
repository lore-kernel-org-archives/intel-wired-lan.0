From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 30 May 2019 16:56:15 -0700
Subject: [Intel-wired-lan] Driver has suspect GRO implementation,
 TCP performance may be compromised.
In-Reply-To: <CAKgT0UdWmu3GjeMd9jmA=5FGQ=5cLnFb51arf+zkX7omc-G1fg@mail.gmail.com>
References: <e070e241-fb65-a5b0-3155-7380a9203bcf@molgen.mpg.de>
 <8627ea1e-8e51-c425-97f6-aeb57176e11a@gmail.com>
 <eb730f01-0c6d-0589-36cc-7193d64c1ee8@molgen.mpg.de>
 <CANn89i+VvwMaHy2Br-0CcC3gPQ+PmG3Urpn4KpqL0P7XBykmcw@mail.gmail.com>
 <20190529093548.3df7ee73@hermes.lan>
 <CAKgT0UdWmu3GjeMd9jmA=5FGQ=5cLnFb51arf+zkX7omc-G1fg@mail.gmail.com>
Message-ID: <50261bc0-2732-5adb-1ff6-a4ac040e39b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 5/30/19 3:52 PM, Alexander Duyck wrote:

> Actually I think there are some parts that don't have any receive
> limits that are supported by the e1000 part. What ends up happening is
> that we only drop the packet if it spans more than one buffer if I
> recall correctly, and buffer size is determined by MTU.
> 
> I always thought MTU only applied to transmit since it is kind of in
> the name. As a result I am pretty sure igb and ixgbe will be able to
> trigger this warning under certain circumstances as well. Also what
> about the case where someone sets the MTU to less than 1500? I think
> most NICs probably don't update their limits in such a case and
> wouldn't it also trigger a similar error?
> 


Linux does not have a notion of MRU, mtu is used for both tx and rx.

Most NIC drivers allocate skb of the maximal size (derived from netdev->mtu)
and program the NIC to drop packets bigger than X bytes  (X also derived from netdev->mtu)

Another interesting point is that Paul host is receiving big packets,
that means that one host in his local network is overriding the 1500 MTU :)

Eventually we could add a netdev->mru and allow few drivers to set
their maximal mru, if bigger than netdev->mtu.

e1000e would probably set netdev->mru to 2048 - sizeof(ethernet headers), if
the driver is operating at MTU = 1500

