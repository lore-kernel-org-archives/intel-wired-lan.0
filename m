From: Toke =?unknown-8bit?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 04 Dec 2020 13:19:32 +0100
Subject: [Intel-wired-lan] [PATCH v2 bpf 2/5] drivers/net: turn XDP
 properties on
In-Reply-To: <20201204102901.109709-3-marekx.majtyka@intel.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-3-marekx.majtyka@intel.com>
Message-ID: <875z5h931n.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

alardam at gmail.com writes:

> From: Marek Majtyka <marekx.majtyka@intel.com>
>
> Turn 'hw-offload' property flag on for:
>  - netronome.

Can you add this to netdevsim as well, please? That way we can add a
test for it in test_offload.py once the userspace bits land in
ethtool...

-Toke

