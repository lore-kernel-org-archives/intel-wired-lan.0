From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Tue, 8 Sep 2020 20:28:14 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 0/6] xsk: exit NAPI loop when
 AF_XDP Rx ring is full
In-Reply-To: <20200908102438.28351aab@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
 <20200904162751.632c4443@carbon>
 <27e05518-99c6-15e2-b801-cbc0310630ef@intel.com>
 <20200904165837.16d8ecfd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <1d2e781e-b26d-4cf0-0178-25b8835dbe26@intel.com>
 <20200907114055.27c95483@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <8f698ac5-916f-9bb0-cce2-f00fba6ba407@intel.com>
 <20200908102438.28351aab@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <12536115-3dae-1efa-5c0d-34fc951fca48@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-09-08 19:24, Jakub Kicinski wrote:
>> I'll start playing around a bit, but again, I think this simple series
>> should go in just to make AF_XDP single core usable*today*.
> No objection from me.

Thanks Jakub, but as you (probably) noticed in the other thread Maxim 
had some valid concerns. Let's drop this for now, and I'll get back 
after some experimentation/hacking.


Again, thanks for the ideas! Very much appreciated!
Bj?rn
