From: Eric Dumazet <edumazet@google.com>
Date: Thu, 15 Mar 2018 15:30:40 +0000
Subject: [Intel-wired-lan] [RFC PATCH 0/2] net:setup XPS mapping for
 each online CPU
In-Reply-To: <cover.1521124830.git.pabeni@redhat.com>
References: <cover.1521124830.git.pabeni@redhat.com>
Message-ID: <CANn89iKPzx+LAK=LPZns_Gt0QGivO_4DAEyvkUfhpv8BeQwQXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Mar 15, 2018 at 8:08 AM Paolo Abeni <pabeni@redhat.com> wrote:

> Currently, most MQ netdevice setup the default XPS configuration mapping
> 1-1
> the first real_num_tx_queues queues and CPUs and no mapping is created for
> the CPUs with id greater then real_num_tx_queues, if any.
>
> As a result, the xmit path for unconnected sockets on such cores
> experiences a
> relevant overhead in netdev_pick_tx(), which needs to dissect each packet
> and
> compute its hash.
>
> Such scenario is easily triggered. e.g. from DNS server under relevant
> load, as
> the user-space process is moved away from the CPUs serving the softirqs
> (note:
> this is beneficial for the overall DNS server performances).
>
> This series introduces an helper to easily setup up XPS mapping for all the
> online CPUs, and use it in the ixgbe driver, demonstrating a relevant
> performance improvement in the above scenario.
>
>
I truly believe XPS should not be setup by devices.

XPS is policy, and policy does belong to user space.

User space knows that CPU 2  and 3 (pure examples) are reserved for storage
interrupts, not NIC ones.

Note that if XPS is not setup, MQ queue selection is just fine by default ;)
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180315/b0626b35/attachment.html>
