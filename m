From: Nick Lowe <nick.lowe@gmail.com>
Date: Mon, 1 Feb 2021 20:06:16 +0000
Subject: [Intel-wired-lan] [PATCH net] igb: Enable RSS for Intel I211
 Ethernet Controller
In-Reply-To: <20210201114545.6278ae5c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201221222502.1706-1-nick.lowe@gmail.com>
 <379d4ef3-02e5-f08a-1b04-21848e11a365@bluematt.me>
 <20210201084747.2cb64c3f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <a7a89e90bf6c3f383fa236b1128db8d012223da0.camel@intel.com>
 <20210201114545.6278ae5c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <CADSoG1uRKexjQJ7Oxqyspzbpx=Qyq2dTbOMp-dEjTSMMySmkFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

It is correct that this is not a regression, it instead has never worked.

My suggestion would be to merge it during the 5.11 cycle rather than
5.12 where possible because the patch is non-invasive and should be
lower risk.

There are significant and tangible real-world benefits to RSS
functioning with the i211 so I do not personally think, on balance,
that it is proportionate and worth waiting for 5.12 to conclude here.
Any thoughts?

More importantly though, after this does release in a stable kernel
(regardless of whether that is 5.11 or 5.12) and this change has had
some time to soak in the field, I do suggest consideration to then
backport this to the 5.4 and 5.10 LTS kernels so that RSS starts to
function there. 5.4 and 5.10 are the release branches that will, of
course, get far more use for the next couple of years.

Best,

Nick
