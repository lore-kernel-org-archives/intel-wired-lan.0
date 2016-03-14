From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 14 Mar 2016 15:32:59 -0400
Subject: [Intel-wired-lan] [PATCH v2 net-next] ixgbe: Avoid unaligned
 access in ixgbe_atr() for LLC packets
In-Reply-To: <CAKgT0Ud9b7MaOk-O4gs3LCMgO+dApCFJ=tOrStk1kuxEE5dShw@mail.gmail.com>
References: <20160314174624.GG5084@oracle.com>
 <CAKgT0Ucnf7Yyzjp_vccimVmjx-ZbYnOfKoTt6rEEZOsOEhVboQ@mail.gmail.com>
 <20160314175909.GH5084@oracle.com>
 <CAKgT0Ud9b7MaOk-O4gs3LCMgO+dApCFJ=tOrStk1kuxEE5dShw@mail.gmail.com>
Message-ID: <20160314193259.GL5084@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On (03/14/16 12:20), Alexander Duyck wrote:
> I figure it is better to just drop it since we don't need to be trying
> to parse ARP packets anyway.

Ok, let me send out v3.

