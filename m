From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 19 Jan 2021 14:24:09 -0800
Subject: [Intel-wired-lan] [PATCH net-next 2/6] net: igb: use
 skb_csum_is_sctp instead of protocol check
In-Reply-To: <aa69157e286b0178bf115124f4b2da254e07a291.1610777159.git.lucien.xin@gmail.com>
References: <cover.1610777159.git.lucien.xin@gmail.com>
 <34c9f5b8c31610687925d9db1f151d5bc87deba7.1610777159.git.lucien.xin@gmail.com>
 <aa69157e286b0178bf115124f4b2da254e07a291.1610777159.git.lucien.xin@gmail.com>
Message-ID: <CAKgT0UencO4hnti1ShWpVUmKm9M0Y_MHHLkGvX-0UQNwYtT+ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 15, 2021 at 10:14 PM Xin Long <lucien.xin@gmail.com> wrote:
>
> Using skb_csum_is_sctp is a easier way to validate it's a SCTP
> CRC checksum offload packet, and there is no need to parse the
> packet to check its proto field, especially when it's a UDP or
> GRE encapped packet.
>
> So this patch also makes igb support SCTP CRC checksum offload
> for UDP and GRE encapped packets.
>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
