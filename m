From: Francesco Ruggeri <fruggeri@arista.com>
Date: Thu, 2 Jul 2020 13:20:18 -0700
Subject: [Intel-wired-lan] [PATCH] igb: reinit_locked() should be called
 with rtnl_lock
In-Reply-To: <61CC2BC414934749BD9F5BF3D5D9404498748B57@ORSMSX112.amr.corp.intel.com>
References: <20200629211801.C3D7095C0900@us180.sjc.aristanetworks.com>
 <20200629171612.49efbdaa@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CA+HUmGjHQPUh1frfy5E28Om9WTVr0W+UQVDsm99beC_mbTeMog@mail.gmail.com>
 <61CC2BC414934749BD9F5BF3D5D940449874358A@ORSMSX112.amr.corp.intel.com>
 <CA+HUmGhfxYY5QiwF8_UYbp0TY-k3u+cTYZDSqV1s=SUFnGCn8g@mail.gmail.com>
 <61CC2BC414934749BD9F5BF3D5D9404498748B57@ORSMSX112.amr.corp.intel.com>
Message-ID: <CA+HUmGi6D8Ci5fk7vyengJN4qOEH6zz18Kw6B9Us-Kav-78oAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>
> So will you be sending a v2 of your patch to include the second fix?

Yes, I am working on it. Just to confirm, v2 should include both fixes, right?

Thanks,
Francesco
