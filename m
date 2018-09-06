From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 6 Sep 2018 20:03:16 +0200
Subject: [Intel-wired-lan] [PATCH v2 1/2] net: ethernet: i40e: fix build
 error
In-Reply-To: <02874ECE860811409154E81DA85FBB5884C7AC01@ORSMSX115.amr.corp.intel.com>
References: <1536114430-21356-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <02874ECE860811409154E81DA85FBB5884C78D88@ORSMSX115.amr.corp.intel.com>
 <eab442369533452a9fc138e310aa57b9@HXTBJIDCEMVIW02.hxtcorp.net>
 <02874ECE860811409154E81DA85FBB5884C7AC01@ORSMSX115.amr.corp.intel.com>
Message-ID: <20180906180316.GB26997@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> I'm more worried about how it interacts with modules. For example,
> we could have i40e and i40evf share some code, but then wouldn't one
> of them become dependent on the other? i.e. you'd have to load i40e
> in order to successfully load i40evf? Or you'd have to have some
> sort of common glue module which you load first, and then load i40e
> and i40evf after? This also creates some interactions with
> out-of-tree modules which make it difficult. It would be nice if we
> could share the code in some way that still resulted in allowing
> each module to be separate...
 
You have a few options here.

1) A library module, containing shared code. Use EXPORT_SYMBOL_GPL()
in the library module, and the kernel runtime linker will link the
calls into the library. Also, modprobe will ensure the library module
is loaded first, before the driver module.

2) Build time sharing of code. Place the shared code into a .o file,
and link it to both modules.

There is nothing particularly difficult here, this all done lots of
times within the kernel. Just look around and see how others do it.

      Andrew
