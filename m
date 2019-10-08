From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 8 Oct 2019 10:48:12 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 2/4] xsk: allow AF_XDP
 sockets to receive packets directly from a queue
In-Reply-To: <CAJ+HfNhcvRP34L3px6ipAsCiZdvLXG02brecwB=T-sXMaT5yRw@mail.gmail.com>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
 <1570515415-45593-3-git-send-email-sridhar.samudrala@intel.com>
 <875zkzn2pj.fsf@toke.dk>
 <CAJ+HfNhcvRP34L3px6ipAsCiZdvLXG02brecwB=T-sXMaT5yRw@mail.gmail.com>
Message-ID: <CAJ+HfNgEC=3MOe4YK_NNzRu6g_srKjWOCaCt09cU51avhWJKMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 8 Oct 2019 at 10:47, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>
[...]
>
> The dependent-read-barrier in READ_ONCE? Another branch -- leave that
> to the branch-predictor already! ;-) No, you're right, performance
> impact here is interesting. I guess the same static_branch could be
> used here as well...
>

...and I think the READ_ONCE can be omitted.
