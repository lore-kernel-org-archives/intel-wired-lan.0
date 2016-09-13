From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Sep 2016 11:30:01 -0700
Subject: [Intel-wired-lan] [net-next PATCH v3 2/3] e1000: add initial
 XDP support
In-Reply-To: <36ECC79A-0810-4D06-A72D-702AD9901E83@intel.com>
References: <1473720399.18970.91.camel@edumazet-glaptop3.roam.corp.google.com>
 <20160912230745.GA24171@ast-mbp.thefacebook.com>
 <1473723968.18970.111.camel@edumazet-glaptop3.roam.corp.google.com>
 <CALx6S35CE+ZYbGm96Y5YKnTqU0zfhg9_h0VSpD3ot8xB-scdFQ@mail.gmail.com>
 <20160913012815.GB25756@ast-mbp.thefacebook.com>
 <CALx6S36u+tQUEVhu0BaLZ6-_0=GSMwxd4m89-H+brVZ-rr-U2g@mail.gmail.com>
 <20160913171340.GA37341@ast-mbp.thefacebook.com>
 <1473788252.18970.177.camel@edumazet-glaptop3.roam.corp.google.com>
 <20160913175926.GA38737@ast-mbp.thefacebook.com>
 <36ECC79A-0810-4D06-A72D-702AD9901E83@intel.com>
Message-ID: <20160913182959.GA38950@ast-mbp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Sep 13, 2016 at 06:28:03PM +0000, Rustad, Mark D wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> >I've looked through qemu and it appears only emulate e1k and tg3.
> >The latter is still used in the field, so the risk of touching
> >it is higher.
> 
> I have no idea what makes you think that e1k is *not* "used in the field".
> I grant you it probably is used more virtualized than not these days, but it
> certainly exists and is used. You can still buy them new at Newegg for
> goodness sakes!

the point that it's only used virtualized, since PCI (not PCIE) have
been long dead.

