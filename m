From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Sep 2016 16:40:41 -0700
Subject: [Intel-wired-lan] [net-next PATCH v3 2/3] e1000: add initial
 XDP support
In-Reply-To: <151DF165-61A2-428A-BD24-04E7704F9724@intel.com>
References: <20160913012815.GB25756@ast-mbp.thefacebook.com>
 <CALx6S36u+tQUEVhu0BaLZ6-_0=GSMwxd4m89-H+brVZ-rr-U2g@mail.gmail.com>
 <20160913171340.GA37341@ast-mbp.thefacebook.com>
 <1473788252.18970.177.camel@edumazet-glaptop3.roam.corp.google.com>
 <20160913175926.GA38737@ast-mbp.thefacebook.com>
 <36ECC79A-0810-4D06-A72D-702AD9901E83@intel.com>
 <20160913182959.GA38950@ast-mbp.thefacebook.com>
 <AB6E7248-F1A3-4C9C-9249-7F25E51BA1E4@intel.com>
 <20160913215208.GA40872@ast-mbp.thefacebook.com>
 <151DF165-61A2-428A-BD24-04E7704F9724@intel.com>
Message-ID: <20160913234039.GA42336@ast-mbp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Sep 13, 2016 at 10:41:12PM +0000, Rustad, Mark D wrote:
> That said, I can see that you have tried to keep the original code path
> pretty much intact. I would note that you introduced rcu calls into the !bpf
> path that would never have been done before. While that should be ok, I
> would really like to see it tested, at least for the !bpf case, on real
> hardware to be sure. 

please go ahead and test. rcu_read_lock is zero extra instructions
for everything but preempt or debug kernels.

