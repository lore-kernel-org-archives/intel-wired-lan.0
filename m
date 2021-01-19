From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 19 Jan 2021 14:25:31 -0800
Subject: [Intel-wired-lan] [PATCH net-next 6/6] net: ixgbevf: use
 skb_csum_is_sctp instead of protocol check
In-Reply-To: <c7cd3ae7df46d579a11c277f9cb258b7955415b2.1610777159.git.lucien.xin@gmail.com>
References: <34c9f5b8c31610687925d9db1f151d5bc87deba7.1610777159.git.lucien.xin@gmail.com>
 <aa69157e286b0178bf115124f4b2da254e07a291.1610777159.git.lucien.xin@gmail.com>
 <c1a1972ea509a7559a8900e1a33212d09f58f3c9.1610777159.git.lucien.xin@gmail.com>
 <7b4d84fe32d588884fcd75c2f6f84eb8cd052622.1610777159.git.lucien.xin@gmail.com>
 <cover.1610777159.git.lucien.xin@gmail.com>
 <f58d50ef96eb1504f4a952cc75a19d21dcf85827.1610777159.git.lucien.xin@gmail.com>
 <c7cd3ae7df46d579a11c277f9cb258b7955415b2.1610777159.git.lucien.xin@gmail.com>
Message-ID: <CAKgT0UdaXj9X47=ggSwTKt2zvG-Wcvtj-GSf9JZWcPaMGy+M2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 15, 2021 at 10:14 PM Xin Long <lucien.xin@gmail.com> wrote:
>
> Using skb_csum_is_sctp is a easier way to validate it's a SCTP CRC
> checksum offload packet, and yet it also makes ixgbevf support SCTP
> CRC checksum offload for UDP and GRE encapped packets, just as it
> does in igb driver.
>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
